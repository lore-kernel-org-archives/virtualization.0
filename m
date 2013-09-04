From: Zoltan Kiss <zoltan.kiss@citrix.com>
Subject: Re: [PATCH] tracing/events: Add bounce tracing to swiotbl-xen
Date: Wed, 4 Sep 2013 16:58:45 +0100
Message-ID: <522758B5.6070607@citrix.com>
References: <1377208048-8963-1-git-send-email-zoltan.kiss@citrix.com>
	<20130822180209.07a2bd00@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130822180209.07a2bd00@gandalf.local.home>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 22/08/13 23:02, Steven Rostedt wrote:
> Please use a more specific name. "bounce" is too generic. I know
> tracepoints are grouped by systems, but its easier for tools to just
> state a tracepoint name than the system:event pair.

Sure, see my v2 patch coming soon.

Zoli
