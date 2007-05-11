From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] lguest: Convert to hrtimer framework
Date: Fri, 11 May 2007 15:03:50 +1000
Message-ID: <1178859830.23513.38.camel@localhost.localdomain>
References: <Line.LNX.4.64.0705090927001.4526@d.namei>
	<Line.LNX.4.64.0705090935580.4526@d.namei>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Line.LNX.4.64.0705090935580.4526@d.namei>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Morris <jmorris@namei.org>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-05-09 at 09:37 -0400, James Morris wrote:
> Convert lguest to the hrtimer framework, enabling dynamic ticks and high 
> resolution timers.

Thanks very much for this James!  Applied after the Great Documentation
patch, so I'm adding some extra verbiage.

Cheers,
Rusty.
