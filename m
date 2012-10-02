From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Linux-next changes for module and virtio trees.
Date: Tue, 02 Oct 2012 15:56:56 +0930
Message-ID: <871uhh4cen.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-devel <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Stephen,

        Please remove my quilt tree
http://ozlabs.org/~rusty/kernel/rr-latest/ from linux-next, and use my
git trees from now on:

git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux.git
Branches:
        modules-next
        virtio-next

For others: beware that these will rebase, usually once after the merge
window closes (so I can work on a more modern tree), and again just
before it opens (where I squash in fixup patches).

Cheers,
Rusty.
