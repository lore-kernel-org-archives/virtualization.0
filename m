From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Sun, 19 Aug 2007 12:24:43 +0300
Message-ID: <46C80C5B.7070009__2172.18792900002$1187515675$gmane$org@qumranet.com>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187313953.6449.70.camel@localhost.localdomain>
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
Cc: kvm-devel@lists.sourceforge.net, Gregory Haskins <ghaskins@novell.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>         2) We either need huge descriptors or some chaining mechanism to
>         handle scatter-gather.
>   

Or, my preference, have a small sglist in the descriptor; if the buffer 
doesn't fit in the sglist follow a pointer and size (stored in the same 
place as the immediate sglist) to an external sglist.

The advantage of this is that it doesn't complicate descriptor 
allocation and accounting (if you have large sglists, suddenly you have 
fewer than expected effective descriptors).



-- 
error compiling committee.c: too many arguments to function
