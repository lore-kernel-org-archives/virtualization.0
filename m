From: Bastian Blank <waldi@debian.org>
Subject: Re: [PATCH 2/2] xen: Add alias to autoload backend drivers
Date: Mon, 27 Jun 2011 18:37:29 +0200
Message-ID: <20110627163728.GA23028__38365.2354511016$1309213647$gmane$org@wavehammer.waldi.eu.org>
References: <20110624215155.GB4735@wavehammer.waldi.eu.org>
	<20110627161327.GO6978@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110627161327.GO6978@dumpdata.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 27, 2011 at 12:13:27PM -0400, Konrad Rzeszutek Wilk wrote:
> On Fri, Jun 24, 2011 at 11:51:55PM +0200, Bastian Blank wrote:
> > All the Xen backend drivers are assigned to a special bus type
> > xen-backend. This allows userspace to load the modules on request.
> Is there a specific version of udev that would take advantage of this?

Was there a version within the last three years that can't? The patch is
tested and udev does its work.

Bastian

-- 
Pain is a thing of the mind.  The mind can be controlled.
		-- Spock, "Operation -- Annihilate!" stardate 3287.2
