From: James Morris <jmorris@namei.org>
Subject: [PATCH 0/2 v05] lguest: TSC & hrtimers
Date: Wed, 9 May 2007 09:34:31 -0400 (EDT)
Message-ID: <Line.LNX.4.64.0705090927001.4526@d.namei>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

The following patches are the latest update of the TSC and hrtimer patches 
I posted on 29/03.

Rusty's original TSC patch has been resynced to the latest lguest repo, 
as has the hrtimer patch, which also incorporates feedback from Jeremy & 
Rusty:

- Change clock event hrtimer to absolute time.  'now' is captured in the 
  host during the hypercall.
- Propagate -ETIME back to the guest timer framework
- Use the API-provided delta via set_next_event()
- Move clock-related code to interrupts_and_traps.c
- Rename hypercall to LHCALL_SET_CLOCKEVENT

This patch also completes previous critical todo items, although handling 
TSC frequency scaling remains to be addressed.

Please review and apply if ok.



-- 
James Morris
<jmorris@namei.org>
