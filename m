From: "Bruce Rogers" <brogers@novell.com>
Subject: [PATCH 0/3][STABLE] KVM: Various issues in virtio_net
Date: Thu, 03 Jun 2010 16:24:18 -0600
Message-ID: <4C07D73202000048000974FB@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: rusty@rustcorp.com.au
Cc: virtualization@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

These are patches which we have found useful for our 2.6.32 based SLES 11 SP1 release. 

The first patch is already upstream, but should be included in 2.6.32 stable tree.

The second patch is a subset of another upstream patch. Again, stable material, applicable to 2.6.32 and 2.6.33.

The third patch solves the last remaining issue we saw when testing kvm configurations with the SUSE certification test suite. Under heavy load, we observed rx stalls (first two patches applied), and this third patch was crafted to address the issue. Please apply to 2.6.32, 2.6.33, and 2.6.34 stable trees.
(I assume this last problem also exists in more recent kernels than 2.6.32, but I haven't validated that.)

With these 3 patches applied we no longer see any issues with virito networking using our certification test suite.

Signed-off-by: Bruce Rogers <brogers@novell.com>
