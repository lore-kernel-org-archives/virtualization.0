From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 21/25][V3] export cpu_gdt_descr
Date: Wed, 15 Aug 2007 11:25:43 -0300
Message-ID: <5d6222a80708150725i45a064bfqfd43139338287988__31920.1494953179$1187188033$gmane$org@mail.gmail.com>
References: <11871823151789-git-send-email-gcosta@redhat.com>
	<11871823373106-git-send-email-gcosta@redhat.com>
	<11871823673236-git-send-email-gcosta@redhat.com>
	<11871823782610-git-send-email-gcosta@redhat.com>
	<11871823892519-git-send-email-gcosta@redhat.com>
	<11871823991803-git-send-email-gcosta@redhat.com>
	<11871824081337-git-send-email-!gcosta@redhat.com>
	<11871824192375-git-send-email-gcosta@redhat.com>
	<11871824292046-git-send-email-gcosta@redhat.com>
	<20070815140339.GG3406@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070815140339.GG3406@bingen.suse.de>
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
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On 8/15/07, Andi Kleen <ak@suse.de> wrote:
> > +#ifdef CONFIG_PARAVIRT
> > +extern unsigned long *cpu_gdt_descr;
>
> No externs in .c files
>
> Normally they should be where the variable is defined
> anyways.
Given that this  variable is defined in head.S, what do you propose?
AFAICT, this is the very duty of this file (x8664_syms.c), and the
extern is also used in other symbols like the memcpy family

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
