From: Chris Gates <gchris@tpg.com.au>
Subject: RSS limitations
Date: Wed, 08 Apr 2009 09:03:03 +1000
Message-ID: <1239145383.22756.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: 491371F0.7020805@codemonkey.ws
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, eddie.dong@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Eddie,

I want to start using the new Intel 10Gige for several ISP services,
looking through the documentation on the 10Gige cards, i can see that
receive-side scaling (RSS) is supported, but RSS does not support
searching for IP/PORT tupples inside PPPoE packets or MPLS packets.

This creates the issue, that i cannot load balance irq's across
different CPU cores for PPPoE and MPLS framed Ethernet packets.

Is there a possibility Intel could extend the RSS system to support
searching and hashing on the IP/PORT tupples inside PPPoE and MPLS?
I assume it would be a fairly simple experimental firmware change.

Failing this, do you see that its possible for VMDq to be used to create
virtual Ethernet cards each with its own MAC address visible by the
switch connected to the physical Ethernet card?
 
Better still, could Intel have a "Linux Virtual Server" (LVS) protocol,
that lets the host decide how to balance (depending on CPU load feedback
for example).

I feel, the limited nature of RSS will limit the usefulness of 10Gige,
Unless RSS is improved, or perhaps I've simply overlooked something.
 
Cheers,
Chris Gates
TPG Internet
