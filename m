From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Tue, 9 Oct 2012 22:09:01 +0100
Message-ID: <20121009210901.GY14867__17609.1450652622$1349819015$gmane$org@jl-vm1.vm.bytemark.co.uk>
References: <874nmajcmj.fsf@codemonkey.ws> <87y5jhpuu2.fsf@rustcorp.com.au>
	<87bogddq0l.fsf@codemonkey.ws> <5072EA14.30809@redhat.com>
	<87k3v1gfw1.fsf@codemonkey.ws> <507333F1.1060000@redhat.com>
	<874nm4u1in.fsf@codemonkey.ws> <87sj9o8qn7.fsf@rustcorp.com.au>
	<87sj9oh0pm.fsf@codemonkey.ws> <87haq48hds.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87haq48hds.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> I don't think it'll be that bad; reset clears the device to unknown,
> bar0 moves it from unknown->legacy mode, bar1/2/3 changes it from
> unknown->modern mode, and anything else is bad (I prefer being strict so
> we catch bad implementations from the beginning).

Will that work, if the guest with kernel that uses modern mode, kexecs
to an older (but presumed reliable) kernel that only knows about legacy mode?

I.e. will the replacement kernel, or (ideally) replacement driver on
the rare occasion that is needed on a running kernel, be able to reset
the device hard enough?

-- Jamie
