From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] virtio: fix memory leak on device removal
Date: Thu, 23 Jul 2009 13:56:58 +0930
Message-ID: <200907231356.59681.rusty__45066.3621108562$1248323476$gmane$org@rustcorp.com.au>
References: <cover.1248181714.git.mst@redhat.com>
	<20090721155909.GB3306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090721155909.GB3306@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, t@redhat.com, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 22 Jul 2009 01:29:09 am Michael S. Tsirkin wrote:
> Free up msi vector tables.

Michael, this papers over the bug, but doesn't actually fix the problem.

The problem is that vp_free_vectors() does not do the reverse of 
vp_request_vectors.  If the author (you) can't get it right, what hope the 
rest of us?

Indeed, if you look harder, you'll see another leak caused by this problem, 
which your patch *didn't* fix.

Thanks,
Rusty.
