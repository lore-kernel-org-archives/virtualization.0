From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] virtio: fix memory leak on device removal
Date: Thu, 23 Jul 2009 13:27:14 +0300
Message-ID: <20090723102714.GD10860__29579.1569668383$1248344966$gmane$org@redhat.com>
References: <cover.1248181714.git.mst@redhat.com>
	<20090721155909.GB3306@redhat.com>
	<200907231356.59681.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200907231356.59681.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, t@redhat.com, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 23, 2009 at 01:56:58PM +0930, Rusty Russell wrote:
> On Wed, 22 Jul 2009 01:29:09 am Michael S. Tsirkin wrote:
> > Free up msi vector tables.
> 
> Michael, this papers over the bug, but doesn't actually fix the problem.
> 
> The problem is that vp_free_vectors() does not do the reverse of 
> vp_request_vectors.  If the author (you) can't get it right, what hope the 
> rest of us?

I agree. This code belongs in free_vectors.
And might as well reset the pointers to make the reversal complete.

> Indeed, if you look harder, you'll see another leak caused by this problem, 
> which your patch *didn't* fix.

Couldn't spot it yet. I'll send out a fixed patch, see if I got
everything covered.

> Thanks,
> Rusty.
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
