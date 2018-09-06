From: David Howells <dhowells@redhat.com>
Subject: [RFC] UAPI: Check headers by compiling all together as C++
Date: Thu, 06 Sep 2018 10:18:17 +0100
Message-ID: <153622549721.14298.8116794954073122489.stgit__39349.8336816721$1536225385$gmane$org@warthog.procyon.org.uk>
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
To: linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Mat Martineau <mathew.j.martineau@linux.intel.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, dhowells@redhat.com, Masahiro Yamada <yamada.masahiro@socionext.com>, keyrings@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Yann Droneaud <ydroneaud@opteya.com>, linux-nilfs@vger.kernel.org, linux-nvdimm@lists.01.org, codalist@coda.cs.cmu.edu, coda@cs.cmu.edu, coreteam@netfilter.org, Kent Overstreet <kent.overstreet@gmail.com>, linux-arm-msm@vger.kernel.org, Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jan Harkes <jaharkes@cs.cmu.edu>, Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, netfilter-devel@vger.kernel.org, linux-fsdevel@vger.kernel.orgf
List-Id: virtualization@lists.linuxfoundation.org


Here's a set of patches that inserts a step into the build process to make
sure that the UAPI headers can all be built together with C++ (if the
compiler being used supports C++).

Note that it's based on a commit from the sound tree to fix usage of u32
and co..

Most of the patches perform fixups, including:

 (1) Fix member names that conflict with C++ reserved words by providing
     alternates that can be used anywhere.  An anonymous union is used so
     that that the conflicting name is still available outside of C++.

 (2) Fix the use of flexible arrays in structs that get embedded (which is
     illegal in C++).

 (3) Remove the use of internal kernel structs in UAPI structures.

 (4) Fix symbol collisions.

 (5) Fix use of sparsely initialised arrays (which g++ doesn't implement).

 (6) Remove some use of PAGE_SIZE since this isn't valid outside of the
     kernel.

There's also:

 (7) Move the coda_psdev.h header file to fs/coda/.

And lastly:

 (8) Compile all of the UAPI headers (with a few exceptions) together as
     C++ to catch new errors occurring as part of the regular build
     process.

Changes for v2:

 - Merge commit from sound tree to fix u32 usage issues
 - Use a switch to fix sparse array initialisation
 - Simplify nilfs2 by performing bitwise ops in LE space not CPU space
 - Handle conflicting fix to use of 'private' in keyctl.h
 - Move kernel internal coda bits to coda internal headers
 - Move coda_psdev.h header to fs/coda/.

The patches can also be found here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=uapi-check

Thanks,
David
---
David Howells (11):
      UAPI: drm: Fix use of C++ keywords as structural members
      UAPI: keys: Fix use of C++ keywords as structural members
      UAPI: virtio_net: Fix use of C++ keywords as structural members
      UAPI: bcache: Fix use of embedded flexible array
      UAPI: coda: Move kernel internals out of public view
      coda: Move internal defs out of include/linux/
      UAPI: netfilter: Fix symbol collision issues
      UAPI: nilfs2: Fix use of undefined byteswapping functions
      UAPI: ndctl: Fix g++-unsupported initialisation in headers
      UAPI: ndctl: Remove use of PAGE_SIZE
      UAPI: Check headers build for C++


 Makefile                                          |    1 
 fs/coda/cache.c                                   |    2 
 fs/coda/cnode.c                                   |    2 
 fs/coda/coda_linux.c                              |    2 
 fs/coda/coda_psdev.h                              |   88 +++++++++++++++
 fs/coda/dir.c                                     |    2 
 fs/coda/file.c                                    |    3 -
 fs/coda/inode.c                                   |    2 
 fs/coda/pioctl.c                                  |    3 -
 fs/coda/psdev.c                                   |    3 -
 fs/coda/symlink.c                                 |    3 -
 fs/coda/upcall.c                                  |    2 
 include/linux/coda_psdev.h                        |   72 ------------
 include/linux/ndctl.h                             |   22 ++++
 include/uapi/drm/i810_drm.h                       |    7 +
 include/uapi/drm/msm_drm.h                        |    7 +
 include/uapi/linux/bcache.h                       |    2 
 include/uapi/linux/coda_psdev.h                   |   18 ---
 include/uapi/linux/keyctl.h                       |    7 +
 include/uapi/linux/ndctl.h                        |   52 ++++-----
 include/uapi/linux/netfilter/nfnetlink_cthelper.h |    2 
 include/uapi/linux/netfilter_ipv4/ipt_ECN.h       |    9 --
 include/uapi/linux/nilfs2_ondisk.h                |   28 ++---
 include/uapi/linux/virtio_net.h                   |    7 +
 scripts/headers-c++.sh                            |  124 +++++++++++++++++++++
 25 files changed, 304 insertions(+), 166 deletions(-)
 create mode 100644 fs/coda/coda_psdev.h
 delete mode 100644 include/linux/coda_psdev.h
 create mode 100644 include/linux/ndctl.h
 create mode 100755 scripts/headers-c++.sh
