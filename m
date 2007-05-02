From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
 relocatable bzImage
Date: Wed, 02 May 2007 14:24:21 -0700
Message-ID: <46390185.30900__16576.4206125916$1178152661$gmane$org@zytor.com>
References: <20070428758.455116000@suse.de>	<20070428175909.1D09D151CA@wotan.suse.de>
	<46338D72.70402@garzik.org>	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com>
	<4634483E.9030307@goop.org>	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>
	<46363A68.6080201@goop.org>	<46385A8A.6070405@redhat.com>
	<4638AB55.20408@goop.org>	<4638F9BE.8090508@zytor.com>
	<m13b2fvsbn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m13b2fvsbn.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> 
> So we won't do this casually and if it there are real problems we will
> remove the ELF magic number.
> 

I think we can use ELF-compatible format just fine, but it would make
more sense to use a non-ELF magic number from the start, instead of
signalling it with a note.  Since bootloaders need to be aware, anyway,
they can just detect this magic and treat is as an Linux calling
convention ELF image, or they can not detect it, and treat it as a
bzImage.  As a side benefit, we:

a) can use a magic number that contains a jump instruction (to keep the
non-bootsector happy);
b) get a proper Linux kernel magic number.

	-hpa
