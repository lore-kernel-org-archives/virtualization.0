From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 3/4] virtio: rng: delay hwrng_register() till driver
	is ready
Date: Tue, 22 Jul 2014 07:43:20 -0400
Message-ID: <20140722114320.GB18750@titan.lakedaemon.net>
References: <cover.1405942162.git.amit.shah@redhat.com>
	<91cb7c5b87cf2ba5ef1bacd55a7ee7bc827293a2.1405942162.git.amit.shah@redhat.com>
	<20140721121116.GA18750@titan.lakedaemon.net>
	<20140721124124.GA7846@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140721124124.GA7846@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: keescook@chromium.org, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 21, 2014 at 08:41:24PM +0800, Herbert Xu wrote:
> On Mon, Jul 21, 2014 at 08:11:16AM -0400, Jason Cooper wrote:
> >
> > > @@ -136,15 +137,6 @@ static int probe_common(struct virtio_device *vdev)
> > >  		return err;
> > >  	}
> > >  
> > > -	err = hwrng_register(&vi->hwrng);
> > > -	if (err) {
> > > -		vdev->config->del_vqs(vdev);
> > > -		vi->vq = NULL;
> > > -		kfree(vi);
> > > -		ida_simple_remove(&rng_index_ida, index);
> > > -		return err;
> > > -	}
> > > -
> > 
> > This needs to stay.  register, and failure to do so, should occur in the
> > probe routine.
> 
> Why? 

hmm, yes. On reviewing the code, my objection was silly.  It mostly
stemmed from the commit message's mentioning of reduced error handling.

thx,

Jason.
