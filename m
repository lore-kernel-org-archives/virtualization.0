From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Translate asm version of ELFNOTE macro	into	preprocessor
	macro
Date: Wed, 23 Aug 2006 14:02:52 -0700
Message-ID: <44ECC27C.2020401@goop.org>
References: <1156333761.12949.35.camel@localhost.localdomain>	
	<44EC6B12.4060909@goop.org>	
	<1156346074.12949.129.camel@localhost.localdomain>	
	<44EC72F3.70505@goop.org>
	<m1sljnml73.fsf@ebiederm.dsl.xmission.com>	
	<44EC94C2.9080608@goop.org>
	<1156362207.19808.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1156362207.19808.69.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ian Campbell <Ian.Campbell@XenSource.com>
Cc: Andrew Morton <akpm@osdl.org>, Virtualization <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Ian Campbell wrote:
> Surprisingly string concatenation doesn't appear to be required for the
> majority of punctuation, at least so far as I can tell with this test
> patch (this is a xen-unstable kernel I had lying around so don't pay too
> much attention to head-xen.S bit). The only problem I found is comma,
> which can't be escaped.
>
> I've no idea how reliably this works across tool chain versions etc
> though. It worked for me ;-)
>   =


I guess that's a broad enough selection of names.  I had assumed it =

would impose normal symbol-like restrictions on the unquoted section =

name.  (I guess ';' would also need quoting.)

    J
