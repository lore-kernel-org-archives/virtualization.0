From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/19] desc_struct integration
Date: Wed, 12 Dec 2007 10:53:45 -0200
Message-ID: <11974640441088-git-send-email-gcosta__43980.3489404314$1197474115$gmane$org@redhat.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1196957800568-git-send-email-gcosta@redhat.com>
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

Since the last version of it received no comments on the interfaces, here
it goes a version, that I feel ready for inclusion.

The comments regarding style, specially the elimination of the #defines in
the desc_struct definition were merged. I also implemented the vmi
functions,
missing last time.

Ingo, in the absense of further complaints, could you please push to the
x86 tree?
