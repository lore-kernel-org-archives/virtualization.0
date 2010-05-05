From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [Pv-drivers] RFC: Network Plugin Architecture (NPA) for vmxnet3
Date: Wed, 5 May 2010 10:29:40 -0700
Message-ID: <201005051029.42052.dtor__47015.9610537395$1273097715$gmane$org@vmware.com>
References: <20100504230225.GP8323@vmware.com>
	<20100505172316.GA25338@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505172316.GA25338@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: pv-drivers@vmware.com
Cc: Christoph Hellwig <hch@infradead.org>, Pankaj Thakkar <pthakkar@vmware.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 05 May 2010 10:23:16 am Christoph Hellwig wrote:
> On Tue, May 04, 2010 at 04:02:25PM -0700, Pankaj Thakkar wrote:
> > The plugin image is provided by the IHVs along with the PF driver and is
> > packaged in the hypervisor. The plugin image is OS agnostic and can be
> > loaded either into a Linux VM or a Windows VM. The plugin is written
> > against the Shell API interface which the shell is responsible for
> > implementing. The API
> 
> We're not going to add any kind of loader for binry blobs into kernel
> space, sorry.  Don't even bother wasting your time on this.
> 

It would not be a binary blob but software properly released under GPL.
The current plan is for the shell to enforce GPL requirement on the
plugin code, similar to what module loaded does for regular kernel
modules.

-- 
Dmitry
