From: David Howells <dhowells@redhat.com>
Subject: [RFC] UAPI: Check headers by compiling all together as C++
Date: Wed, 05 Sep 2018 16:54:27 +0100
Message-ID: <153616286704.23468.584491117180383924.stgit__33852.0844736651$1536162759$gmane$org@warthog.procyon.org.uk>
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
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Mat Martineau <mathew.j.martineau@linux.intel.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, dhowells@redhat.com, Masahiro Yamada <yamada.masahiro@socionext.com>, keyrings@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, linux-nilfs@vger.kernel.org, linux-nvdimm@lists.01.org, codalist@coda.cs.cmu.edu, coda@cs.cmu.edu, coreteam@netfilter.org, Kent Overstreet <kent.overstreet@gmail.com>, linux-arm-msm@vger.kernel.org, Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>, Jan Harkes <jaharkes@cs.cmu.edu>, Michal Marek <michal.lkml@markovi.net>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Rob
List-Id: virtualization@lists.linuxfoundation.org


Here's a set of patches that inserts a step into the build process to make
sure that the UAPI headers can all be built together with C++ (if the
compiler being used supports C++).  All but the final patch perform fixups,
including:

 (1) Fix member names that conflict with C++ reserved words by providing
     alternates that can be used anywhere.  An anonymous union is used so
     that that the conflicting name is still available outside of C++.

 (2) Fix the use of flexible arrays in structs that get embedded (which is
     illegal in C++).

 (3) Remove the use of internal kernel structs in UAPI structures.

 (4) Fix symbol collisions.

 (5) Replace usage of u32 and co. with __u32 and co.

 (6) Fix use of sparsely initialised arrays (which g++ doesn't implement).

 (7) Remove some use of PAGE_SIZE since this isn't valid outside of the
     kernel.

And lastly:

 (8) Compile all of the UAPI headers (with a few exceptions) together as
     C++ to catch new errors occurring as part of the regular build
     process.

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
      UAPI: coda: Don't use internal kernel structs in UAPI
      UAPI: netfilter: Fix symbol collision issues
      UAPI: nilfs2: Fix use of undefined byteswapping functions
      UAPI: sound: Fix use of u32 and co. in UAPI headers
      UAPI: ndctl: Fix g++-unsupported initialisation in headers
      UAPI: ndctl: Remove use of PAGE_SIZE
      UAPI: Check headers build for C++


 Makefile                                          |    1 
 include/linux/ndctl.h                             |   22 ++++
 include/uapi/drm/i810_drm.h                       |    7 +
 include/uapi/drm/msm_drm.h                        |    7 +
 include/uapi/linux/bcache.h                       |    2 
 include/uapi/linux/coda_psdev.h                   |    4 +
 include/uapi/linux/keyctl.h                       |    7 +
 include/uapi/linux/ndctl.h                        |   20 ++-
 include/uapi/linux/netfilter/nfnetlink_cthelper.h |    2 
 include/uapi/linux/netfilter_ipv4/ipt_ECN.h       |    9 --
 include/uapi/linux/nilfs2_ondisk.h                |   21 ++--
 include/uapi/linux/virtio_net.h                   |    7 +
 include/uapi/sound/skl-tplg-interface.h           |  106 +++++++++---------
 scripts/headers-c++.sh                            |  124 +++++++++++++++++++++
 14 files changed, 255 insertions(+), 84 deletions(-)
 create mode 100644 include/linux/ndctl.h
 create mode 100755 scripts/headers-c++.sh
