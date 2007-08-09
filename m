From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 23/25] [PATCH] paravirt hooks for arch initialization
Date: Thu, 9 Aug 2007 19:03:03 +0100
Message-ID: <20070809190303.214e5457@the-village.bc.nu>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865468394005-git-send-email-gcosta@redhat.com>
	<11865468431616-git-send-email-gcosta@redhat.com>
	<200708081144.04119.ak@suse.de> <46BB5258.8040609@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46BB5258.8040609@goop.org>
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
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, Steven@smtp2.linux-foundation.org, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

> What's the EBDA actually used for?  The only place which seems to use
> ebda_addr is in the e820 code to avoid that area as RAM.

It belongs to the firmware. 
