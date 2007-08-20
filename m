From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Mon, 20 Aug 2007 09:50:06 -0400
Message-ID: <1187617806.4363.179.camel__33547.6797460162$1187618820$gmane$org@ghaskins-t60p.haskins.net>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<46C80C5B.7070009@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C80C5B.7070009@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-08-19 at 12:24 +0300, Avi Kivity wrote:
> Rusty Russell wrote:
> >         2) We either need huge descriptors or some chaining mechanism to
> >         handle scatter-gather.
> >   
> 
> Or, my preference, have a small sglist in the descriptor;


Define "small" ;)

There a certainly patterns that cannot/will-not take advantage of SG
(for instance, your typical network rx path), and therefore the sg
entries are wasted in some cases.  Since they need to be (IMHO) u64,
they suck down at least 8 bytes a piece.  Because of this I elected to
use the model of one pointer per descriptor, with an external descriptor
for SG.  What are your thoughts on this?

-Greg
