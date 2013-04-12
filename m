From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 2/2] tcm_vhost: Use vq->private_data to indicate if
	the endpoint is setup
Date: Fri, 12 Apr 2013 14:37:54 +0300
Message-ID: <20130412113754.GE23467@redhat.com>
References: <1364437048-19932-1-git-send-email-asias@redhat.com>
	<1364437048-19932-3-git-send-email-asias@redhat.com>
	<20130328061659.GA16438@redhat.com>
	<20130328081002.GA4915@hj.localdomain>
	<20130328083330.GA17829@redhat.com>
	<20130328084715.GA14853@hj.localdomain>
	<20130328090615.GB18482@redhat.com>
	<20130329062750.GB32106@hj.localdomain>
	<20130331082312.GJ23484@redhat.com>
	<874nfp7tai.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <874nfp7tai.fsf@rustcorp.com.au>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 02, 2013 at 09:27:57AM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > Rusty's currently doing some reorgs of -net let's delay
> > cleanups there to avoid stepping on each other's toys.
> > Let's focus on scsi here.
> > E.g. any chance framing assumptions can be fixed in 3.10?
> 
> I am waiting for your removal of the dma-compelete ordering stuff in
> vhost-net.
> 
> Cheers,
> Rusty.

Now, it looks like it's actually a smart datastructure.
It allows signalling consumptions from multiple
without any locks, with multiple consumers, and just
a single kref counter.
Nothing simpler than a producer/consumer does this.
Yes it can in theory delay some tx completions a bit but
normally no one is waiting for them.

We can refactor it to save some memory, and cleanup
the code, playing with this now.
