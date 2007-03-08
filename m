From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [RFC/PATCH PV_OPS X86_64 05/17] pravirt_ops - segments
Date: Wed, 7 Mar 2007 22:49:42 -0800
Message-ID: <20070308064942.GA10574@sequoia.sous-sol.org>
References: <20070308054422.820010000@redhat.com>
	<1173333727.25848.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1173333727.25848.6.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

* Steven Rostedt (rostedt@goodmis.org) wrote:
> --- clean-start.orig/include/asm-x86_64/segment.h
> +++ clean-start/include/asm-x86_64/segment.h
> @@ -37,8 +37,14 @@
>  #define GS_TLS_SEL ((GDT_ENTRY_TLS_MIN+GS_TLS)*8 + 3)
>  #define FS_TLS_SEL ((GDT_ENTRY_TLS_MIN+FS_TLS)*8 + 3)
>  =

> +#define __HV_CS 0x80  /* 16*8 */
> +#define __HV_DS 0x88  /* 17*8 */
> +
> +#define GDT_ENTRY_HV_CS 16
> +#define GDT_ENTRY_HV_DS 17
> +

Hmm, this one is not technically needed for pv_ops, looks like lguest
bleeding in ;-)
