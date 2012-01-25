From: Stephen Hemminger <shemminger@vyatta.com>
Subject: lguest documentation
Date: Wed, 25 Jan 2012 09:57:16 -0800
Message-ID: <20120125095716.78ad3f2d@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Rusty Russell <rusty@rustcorp.com.au>, Davidlohr Bueso <dave@gnu.org>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

After moving lguest to tools the documentation index was not updated.

Documentation/virtual/00-INDEX still refers to lguest/ when in fact
the documentation is now over in tools/lguest.  Maybe make a symlink,
or change the reference in the index?
