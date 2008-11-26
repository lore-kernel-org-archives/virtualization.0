From: Gleb Natapov <gleb@redhat.com>
Subject: Host<->guest channel interface advice needed
Date: Wed, 26 Nov 2008 14:39:19 +0200
Message-ID: <20081126123919.GC3521__15466.0549051643$1227703314$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hello,

 I'd like to ask what would be the best user space interface for generic
guest<->host communication channel. The channel will be used to pass
mouse events to/from a guest or by managements software to communicate
with agents running in a guests or for something similar.

The interfaces that are being considered are netlink socket (only datagram
semantics, linux specific), new socket family or character device with
different minor number for each channel. Which one better suits for
the purpose?  Is there other kind of interface to consider? New socket
family looks like a good choice, but it would be nice to hear other
opinions before starting to work on it.

Thanks,

--
			Gleb.
