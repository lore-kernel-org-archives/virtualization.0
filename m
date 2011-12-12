From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [RFC 0/4] virtio-mmio transport
Date: Mon, 12 Dec 2011 14:45:26 +0000
Message-ID: <201112121445.27873.paul__34071.1617064246$1323701881$gmane$org@codesourcery.com>
References: <1321282528-19070-1-git-send-email-peter.maydell@linaro.org>
	<201112120252.35295.paul@codesourcery.com>
	<1323688579.2391.11.camel@hornet.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1323688579.2391.11.camel@hornet.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> I can do that, but not this year (on holiday from Friday 16th, without
> any access to Internet whatsoever :-) One think to be decided is in what
> order the halfs should be filled? Low first, then high? High then low?
> Does it matter at all? :-)

My inital though was that you shouldn't be changing this value when the ring 
is enabled.  Unfortunately you disable the ring by setting the address to zero 
so that argument doesn't work :-/

I suggest that the device to buffer writes to the high part, and construct the 
actual 64-bit value when the low part is written.  That allows 32-bit guests 
can ignore the high part entirely.  Requiring the guest always write high then 
low also works, though I don't see any benefit to either guest or host.

Acting on writes as soon as they occur is not a viable option as it causes the 
device to be enabled before the full address has bee written.  You could say 
the address takes effect after both halves have been written, writes must come 
in pairs, but may occur in either order.  However there is a risk that host 
and guest will somehow get out of sync on which values pair together, so IMO 
this is a bad idea.


If you can't stomach the above then I guess changing the condition for ring 
enablement to QueueNum != 0 and rearanging the configuration sequence 
appropriately would also do the trick.  Having this be different between PCI 
and mmio is probably not worth the confusion though.

Paul
