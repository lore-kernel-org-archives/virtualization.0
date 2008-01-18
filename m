From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/7] More lguest massage.
Date: Thu, 17 Jan 2008 22:35:43 -0200
Message-ID: <1200616550283-git-send-email-gcosta__40912.1563345709$1200616651$gmane$org@redhat.com>
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
To: lguest@ozlabs.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This series takes one more step towards cpu-ification of lguest.
As for rusty's last suggestion, I get rid of the whole bunch
of "struct lguest *lg = cpu->lg" statements around by using
lg_cpu as our base structure wherever it matters. (this saves us
11 lines)
