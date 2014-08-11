From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 1/2] rngd: add udev rule to source from hwrng if
	virtio-rng present
Date: Mon, 11 Aug 2014 12:45:27 +0530
Message-ID: <20140811071527.GB4184@grmbl.mre>
References: <cover.1407416628.git.amit.shah@redhat.com>
	<dd2ddb8458e5ab5cffceb7fac2e3f71e9e2197f3.1407416628.git.amit.shah@redhat.com>
	<53E3D3FF.70707@linux.intel.com> <20140808090715.GG14400@grmbl.mre>
	<53E54533.8030109@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <53E54533.8030109@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: jgarzik@bitpay.com, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, duwe@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 08 Aug 2014 [14:46:27], H. Peter Anvin wrote:
> On 08/08/2014 02:07 AM, Amit Shah wrote:
> >
> > 
> >>  To
> >> some degree the above is obsolete when we get khwrngd widely deployed,
> >> but that is a new-kernel-only kind of thing.
> > 
> > Right - I'm wondering if any such changes as propsed here are now
> > obsolted already by khwrngd?
> > 
> 
> In this case, yes, khwrngd would be a better solution for current kernels.

I think that's OK with me.

What's the suggested value for rng->quality, though, for virtio-rng
that I can use to ensure the kthread starts?

Should I use the 700 (70%) as proposed in the original patchset?  I'm
not exactly sure how that value will be used as well..


		Amit
