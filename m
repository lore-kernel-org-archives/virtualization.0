From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/5] vringh
Date: Tue, 19 Feb 2013 08:59:27 +1030
Message-ID: <1361226573-12481-1-git-send-email-rusty@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

This introduces vringh, which are generic accessors for virtio rings (host side).
There's a host-side implementation in vhost, but it assumes that the rings are
in userspace, and is tied to the vhost implementation.  I have patches to adapt
it to use vringh, but I'm pushing this in the next merge window for Sjur, who has
CAIF patches which need it.

This also includes a test program in tools/virtio.  There's a fixup patch for
the current tools, since they didn't compile for me.  MST?

Review and comments welcome!
Rusty.
