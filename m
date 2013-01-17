From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFCv2 00/12] Introduce host-side virtio queue and CAIF Virtio.
Date: Thu, 17 Jan 2013 21:05:49 +1030
Message-ID: <87d2x4xfju.fsf@rustcorp.com.au>
References: <20121206102750.GF10837@redhat.com>
	<877goc0wac.fsf@rustcorp.com.au>
	<CAJK669bP41oBhJ=MB64NS21Ag7XO5WswuTiVKCFTb96nvmyBiw@mail.gmail.com>
	<87pq1f2rj0.fsf@rustcorp.com.au> <87wqvl1g9s.fsf@rustcorp.com.au>
	<CAJK669Z-bGTeQe8qJpTJP7simbSvQ8cgFZefs5QRMkmxtFYY4g@mail.gmail.com>
	<87pq1c1uj4.fsf@rustcorp.com.au> <877gnk1ayv.fsf@rustcorp.com.au>
	<20130114173914.GB19207@redhat.com>
	<874nihzuoz.fsf@rustcorp.com.au>
	<20130116081606.GB11465@redhat.com>
	<87k3rcy2y2.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k3rcy2y2.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> writes:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> On Wed, Jan 16, 2013 at 01:43:32PM +1030, Rusty Russell wrote:
>>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>> >> +static int resize_iovec(struct vringh_iov *iov, gfp_t gfp)
>>> >> +{
>>> >> +	struct iovec *new;
>>> >> +	unsigned int new_num = iov->max * 2;
>>> >
>>> > We must limit this I think, this is coming
>>> > from userspace. How about UIO_MAXIOV?
>>> 
>>> We limit it to the ring size already;
>>
>> 1. do we limit it in case there's a loop in the descriptor ring?

I didn't get a chance to do these revisions, as I spent today debugging
the test framework.  I won't get any more work on it until next week, so
I've posted a rough series anyway for feedback (can also be found
in my pending-rebases branch on kernel.org).

Thanks!
Rusty.
