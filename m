From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
Date: Wed, 5 Sep 2018 21:22:11 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1809052120510.24932__9103.08154202557$1536175690$gmane$org@n3.vanv.qr>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
	<20180905165552.GB25206@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180905165552.GB25206@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Mat Martineau <mathew.j.martineau@linux.intel.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, keyrings@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, linux-nilfs@vger.kernel.org, linux-nvdimm@lists.01.org, codalist@coda.cs.cmu.edu, coda@cs.cmu.edu, coreteam@netfilter.org, Kent Overstreet <kent.overstreet@gmail.com>, linux-kbuild@vger.kernel.org, linux-arm-msm@vger.kernel.org, Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>, Jan Harkes <jaharkes@cs.cmu.edu>, Michal Marek <michal.lkml@markovi.net>, linux-api@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 2018-09-05 18:55, Greg KH wrote:

>On Wed, Sep 05, 2018 at 04:54:27PM +0100, David Howells wrote:
>> 
>> Here's a set of patches that inserts a step into the build process to make
>> sure that the UAPI headers can all be built together with C++ (if the
>> compiler being used supports C++).  All but the final patch perform fixups,
>> including:
>
>Wait, why do we care?  What has recently changed to start to directly
>import kernel uapi files into C++ code?

With C++11, C++ has become a much nicer language to use (for userspace, anyway).

>And if userspace wants to do this, can't they do the C namespace trick
>themselves when they do the import?

The only trick is to use an extra C source file and extensively wrap things.
