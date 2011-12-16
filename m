From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] [RFC 0/4] virtio-mmio transport
Date: Fri, 16 Dec 2011 16:06:53 +1030
Message-ID: <87iplhoz62.fsf__34446.5723298073$1324241788$gmane$org@rustcorp.com.au>
References: <1321282528-19070-1-git-send-email-peter.maydell@linaro.org>
	<201112120252.35295.paul@codesourcery.com>
	<1323688579.2391.11.camel@hornet.cambridge.arm.com>
	<201112121445.27873.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201112121445.27873.paul@codesourcery.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>, Pawel Moll <pawel.moll@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, virtualization@lists.linux-foundation.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Liguori <anthony@codemonkey.ws>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 12 Dec 2011 14:45:26 +0000, Paul Brook <paul@codesourcery.com> wrote:
> > I can do that, but not this year (on holiday from Friday 16th, without
> > any access to Internet whatsoever :-) One think to be decided is in what
> > order the halfs should be filled? Low first, then high? High then low?
> > Does it matter at all? :-)
> 
> My inital though was that you shouldn't be changing this value when the ring 
> is enabled.  Unfortunately you disable the ring by setting the address to zero 
> so that argument doesn't work :-/

It only does that after a reset, and since reset should set the values
to 0 (I don't think the spec says that, but it will for the new config)
we needn't do it at all.

It's just a convenient value for the driver to read and know the ring
has been cleaned up.

I think initialize by QueueNum makes sense.

Thanks,
Rusty.
