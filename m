From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC] add domain builder support for bzImage kernels
Date: Mon, 18 Jun 2007 11:47:02 +0200
Message-ID: <46765496.8070603@redhat.com>
References: <4672C510.3070208@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4672C510.3070208@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, Xen-devel <xen-devel@lists.xensource.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

   Hi,

> +    if ( dom->parms.bsd_symtab )
> +        xc_dom_load_elf_symtab(dom, elf, 1);

You can just drop that.  The elf symtab stuff is used by BSD kernels 
only, it is never ever used with Linux and thus not required for the 
(linux-only) bzImage loader.

cheers,
   Gerd
