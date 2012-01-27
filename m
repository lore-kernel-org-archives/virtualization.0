From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lguest documentation
Date: Fri, 27 Jan 2012 11:52:57 +1030
Message-ID: <87sjj2c51q.fsf@rustcorp.com.au>
References: <20120125095716.78ad3f2d@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120125095716.78ad3f2d@nehalam.linuxnetplumber.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <shemminger@vyatta.com>, Davidlohr Bueso <dave@gnu.org>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 25 Jan 2012 09:57:16 -0800, Stephen Hemminger <shemminger@vyatta.com> wrote:
> After moving lguest to tools the documentation index was not updated.
> 
> Documentation/virtual/00-INDEX still refers to lguest/ when in fact
> the documentation is now over in tools/lguest.  Maybe make a symlink,
> or change the reference in the index?

Kill the reference.

From: Rusty Russell <rusty@rustcorp.com.au>
Subject: lguest: remove reference from Documentation/virtual/00-INDEX

We're in tools/lguest now.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/Documentation/virtual/00-INDEX b/Documentation/virtual/00-INDEX
--- a/Documentation/virtual/00-INDEX
+++ b/Documentation/virtual/00-INDEX
@@ -4,8 +4,6 @@ 00-INDEX
 	- this file.
 kvm/
 	- Kernel Virtual Machine.  See also http://linux-kvm.org
-lguest/
-	- Extremely simple hypervisor for experimental/educational use.
 uml/
 	- User Mode Linux, builds/runs Linux kernel as a userspace program.
 virtio.txt
