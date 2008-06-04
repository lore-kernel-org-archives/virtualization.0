From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions with
	callbacks (not word wrapped)
Date: Wed, 4 Jun 2008 10:00:16 +0200
Message-ID: <200806041000.16291.borntraeger@de.ibm.com>
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806031449.14385.borntraeger@de.ibm.com>
	<200806031930.09556.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <200806031930.09556.arnd@arndb.de>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag, 3. Juni 2008 schrieb Arnd Bergmann:
> I don't see a reason to make this data structure known to other files,
> so why not leave it in hvc_console.c?

Yes, Fixed. I moved it for a ealier version of this patch. Currently its not 
necessary. Dont know if I need to move it again if I work on Rusty's ideas.

Christian
