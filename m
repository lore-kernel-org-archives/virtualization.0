From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [PATCH][v3.2.y] xen-netfront: delay gARP until backend switches to
	Connected
Date: Fri, 15 Mar 2013 13:56:45 -0400
Message-ID: <514360DD.8050406__47548.7080439509$1363647002$gmane$org@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, netdev@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello,

Please consider including upstream commit 
08e34eb14fe4cfd934b5c169a7682a969457c4ea in the next v3.2.y release.
It was included upstream as of v3.3-rc1.  It has been tested and 
confirmed to resolve http://bugs.launchpad.net/bugs/1154608 .

commit 08e34eb14fe4cfd934b5c169a7682a969457c4ea
Author: Laszlo Ersek <lersek@redhat.com>
Date:   Sun Dec 11 01:48:59 2011 +0000

     xen-netfront: delay gARP until backend switches to Connected


Sincerely,

Joseph Salisbury
