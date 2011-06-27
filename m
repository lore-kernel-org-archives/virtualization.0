From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: [PATCH 2/2] xen: Add alias to autoload backend
	drivers
Date: Mon, 27 Jun 2011 12:51:10 -0400
Message-ID: <20110627165109.GB13335__20977.7521588423$1309193527$gmane$org@dumpdata.com>
References: <20110624215155.GB4735@wavehammer.waldi.eu.org>
	<20110627161327.GO6978@dumpdata.com>
	<20110627163728.GA23028@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110627163728.GA23028@wavehammer.waldi.eu.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bastian Blank <waldi@debian.org>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 27, 2011 at 06:37:29PM +0200, Bastian Blank wrote:
> On Mon, Jun 27, 2011 at 12:13:27PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Fri, Jun 24, 2011 at 11:51:55PM +0200, Bastian Blank wrote:
> > > All the Xen backend drivers are assigned to a special bus type
> > > xen-backend. This allows userspace to load the modules on request.
> > Is there a specific version of udev that would take advantage of this?
> 
> Was there a version within the last three years that can't? The patch is
> tested and udev does its work.

Ok, that answers that question. Queue up for 3.1
