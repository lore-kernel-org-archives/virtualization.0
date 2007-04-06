From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 0/4] Clean up asm/bugs.h, identify_cpu() and update COMPAT_VDSO
Date: Fri, 06 Apr 2007 15:41:52 -0700
Message-ID: <20070406224152.556848893@goop.org>
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

Four patches:
 - clean up asm/bugs.h, by moving all the C code into its own C file
 - split identify_cpu() into boot and secondary variants, so that
   boot-time setup functions can be marked __init
 - repost of the COMPAT_VDSO patches with a bit more robustness from
   unknown DT_tags, and functions marked __init, since all this is
   boot-time only setup.

Thanks,
	J

-- =
