From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/4] paravirt clock series.
Date: Thu,  8 May 2008 13:48:31 +0200
Message-ID: <1210247315-20472-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel@lists.sourceforge.net>
List-Help: <mailto:kvm-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: kvm-devel-bounces@lists.sourceforge.net
Errors-To: kvm-devel-bounces@lists.sourceforge.net
To: virtualization@lists.osdl.org, kvm-devel@lists.sourceforge.net
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Respin of the paravirt clock patch series.

On the host side the kvm paravirt clock is made compatible with the
xen clock.

On the guest side some xen code has been factored out into a separate
source file shared by both kvm and xen clock implementations.

This time it should work ok for kvm smp guests ;)

cheers,
  Gerd


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
