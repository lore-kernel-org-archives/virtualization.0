From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Sun, 27 May 2007 01:19:28 +0100
Message-ID: <4658CE90.5090008@goop.org>
References: <4656FB8F.4090604@goop.org>
	<m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
	<4658C704.2050405@goop.org> <4658CD70.2080702@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4658CD70.2080702@zytor.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Pardon me for saying it, but it's hardly a hardship to add support for a
> single additional constant in existing code.  I'm starting to think this
> argument is approaching not just the silly, but downright ridiculous.
>   

Well, if the existing code is a standard libelf/libbfd, it could be tricky.

> Another option is to have the ELF header at a nonzero offset.
>   

Yes, that's exactly what I'm proposing.

    J
