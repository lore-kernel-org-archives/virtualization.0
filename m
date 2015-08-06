From: Juergen Gross <jgross@suse.com>
Subject: maintainership of arch/x86/include/asm/paravirt_types.h
Date: Thu, 6 Aug 2015 14:20:13 +0200
Message-ID: <55C350FD.6050004__11643.1930721321$1438863639$gmane$org@suse.com>
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
To: "jeremy@goop.org" <jeremy@goop.org>, "chrisw@sous-sol.org" <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

I just realized that according to MAINTAINERS the file
arch/x86/include/asm/paravirt_types.h isn't part of the
PARAVIRT_OPS INTERFACE, but of x86.

Is this on purpose? I don't think so.


Juergen
