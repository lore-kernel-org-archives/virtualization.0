From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 23/25] [PATCH] paravirt hooks for arch initialization
Date: Fri, 10 Aug 2007 15:08:35 -0300
Message-ID: <5d6222a80708101108y62ebfa26n9f47bfc52b48f4a8__13702.6810939007$1186769519$gmane$org@mail.gmail.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865468394005-git-send-email-gcosta@redhat.com>
	<11865468431616-git-send-email-gcosta@redhat.com>
	<200708081144.04119.ak@suse.de> <46BB5258.8040609@goop.org>
	<20070809190303.214e5457@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809190303.214e5457@the-village.bc.nu>
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steven@smtp2.linux-foundation.org, lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On 8/9/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > What's the EBDA actually used for?  The only place which seems to use
> > ebda_addr is in the e820 code to avoid that area as RAM.
>
> It belongs to the firmware.

Wouldn't it be better, then, to just skip this step unconditionally if
we are running a paravirtualized guest? What do we from doing it?

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
