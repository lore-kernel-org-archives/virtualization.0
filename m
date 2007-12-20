From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/15] adjust pvops to accomodate its x86_64 variant
Date: Thu, 20 Dec 2007 18:03:55 -0200
Message-ID: <11981810504172-git-send-email-gcosta__37196.2019744844$1198181325$gmane$org@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi folks,

With this series, the bulk of the work of pvops64 is done.
Here, I integrate most of the paravirt.c and paravirt.h files, making
them applicable to both architectures.

CONFIG_PARAVIRT is _not_ present yet. Basically, this code is missing page
table integration (patches currently being worked on by Jeremy).

Enjoy
