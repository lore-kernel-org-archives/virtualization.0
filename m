From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH RFC 6/7] i386: make the bzImage payload an ELF file
Date: Wed, 6 Jun 2007 21:47:20 -0400
Message-ID: <200706062147.21225.rob__25153.5840835006$1181180937$gmane$org@landley.net>
References: <20070606225837.654272428@goop.org>
	<20070606230922.476662240@goop.org> <4667462A.2010404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4667462A.2010404@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 06 June 2007 7:41 pm, H. Peter Anvin wrote:
> This makes vmlinux (normally stripped) recoverable from the bzImage file
> and so anything that is currently booting vmlinux would be serviced by
> this scheme.

Would this make it sane to strip the initramfs image out of vmlinux with 
objdump and replace it with another one, or are there offsets resolved during 
the build that stop that for vmlinux?

Rob
-- 
The Google cluster became self-aware at 2:14am EDT August 29, 2007...
