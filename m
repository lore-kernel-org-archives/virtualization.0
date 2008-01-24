From: Rusty Russell <rusty@rustcorp.com.au>
Subject: lack of ->remove in 9p virtio driver
Date: Thu, 24 Jan 2008 11:18:57 +1100
Message-ID: <200801241118.57367.rusty__36060.7626302682$1201134107$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Eric,

    Just cleaning up patches for 2.6.25 merge, and noticed that 
net/9p/trans_virtio.c doesn't have a remove function.  This will crash when 
removing the module (console doesn't have one because it can't really be 
removed).

    I'll push the latest queue in a couple of hours: the most important thing 
is that it's now drivers' responsibility to call (the new!) 
vdev->config->reset() function on shutdown.

Cheers,
Rusty.
