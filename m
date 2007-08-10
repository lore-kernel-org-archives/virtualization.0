From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 23/25] [PATCH] paravirt hooks for arch initialization
Date: Fri, 10 Aug 2007 13:30:52 -0700
Message-ID: <46BCCAFC.5090107__47935.1055612371$1186778088$gmane$org@goop.org>
References: <11865467522495-git-send-email-gcosta@redhat.com>	
	<11865468394005-git-send-email-gcosta@redhat.com>	
	<11865468431616-git-send-email-gcosta@redhat.com>	
	<200708081144.04119.ak@suse.de> <46BB5258.8040609@goop.org>	
	<20070809190303.214e5457@the-village.bc.nu>
	<5d6222a80708101108y62ebfa26n9f47bfc52b48f4a8@mail.gmail.com>
	<46BCB3A5.8090504@goop.org> <46BCB9C5.4050103@redhat.com>
	<46BCC414.7060504@goop.org> <46BCC6DF.2040301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46BCC6DF.2040301@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, Steven@smtp2.linux-foundation.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> Indeed, as the EBDA_ADDR_POINTER is not aligned, this may work even
> better.
>
> It seems to me safe to assume that if we read zero on that line:
>
> ebda_addr = *(unsigned short *)__va(EBDA_ADDR_POINTER);
>
> We could just do ebda_size = 0 and go home happy, skipping the rest of
> the process.

Sure, but it should use probe_kernel_addr as well, just so that it will
be robust against having that page unmapped too.

    J
