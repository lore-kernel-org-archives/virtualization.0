From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/3][STABLE] KVM: Various issues in virtio_net
Date: Fri, 4 Jun 2010 10:08:49 +0930
Message-ID: <201006041008.49840.rusty@rustcorp.com.au>
References: <4C07D73202000048000974FB@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C07D73202000048000974FB@sinclair.provo.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bruce Rogers <brogers@novell.com>
Cc: virtualization@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 4 Jun 2010 07:54:18 am Bruce Rogers wrote:
> These are patches which we have found useful for our 2.6.32 based SLES 11 SP1 release. 
> 
> The first patch is already upstream, but should be included in 2.6.32 stable tree.
> 
> The second patch is a subset of another upstream patch. Again, stable material, applicable to 2.6.32 and 2.6.33.
> 
> The third patch solves the last remaining issue we saw when testing kvm configurations with the SUSE certification test suite. Under heavy load, we observed rx stalls (first two patches applied), and this third patch was crafted to address the issue. Please apply to 2.6.32, 2.6.33, and 2.6.34 stable trees.

Hi Bruce, thanks for these.

netdev is the right place for these patches.  I'll send the first two to
stable@kernel.org myself; please add the following two lines to the last one
and repost to netdev@vger.kernel.org.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: stable@kernel.org

Thanks!
Rusty.
