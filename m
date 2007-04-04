From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 0/6] Various cleanups
Date: Tue, 03 Apr 2007 18:06:55 -0700
Message-ID: <20070404010655.400913479@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Andi,

Here's a little batch of cleanups:
 - re-enable VDSO when PARAVIRT is enabled
 - make the parainstructions symbols match the
   other altinstructions naming convention
 - add kernel command-line options to disable altinstructions for
   smp and pv_ops

Oh, and I'm mailing your noreplacement patch back at you, for no
particularly good reason.

	J

-- =
