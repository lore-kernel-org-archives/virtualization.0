From: Greg KH <greg@kroah.com>
Subject: Re: Patch to auto-load MSFT PV NIC driver
Date: Sat, 8 May 2010 07:27:16 -0700
Message-ID: <20100508142716.GA32133@kroah.com>
References: <4BE453510200003000084906@sinclair.provo.novell.com>
	<8AFC7968D54FB448A30D8F38F259C5621AFFB3F9@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C5621AFFB3F9@TK5EX14MBXC114.redmond.corp.microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "Virtualization@lists.osdl.org" <Virtualization@lists.osdl.org>, Ky Srinivasan <ksrinivasan@novell.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, May 08, 2010 at 01:52:01PM +0000, Hank Janssen wrote:
> 
> 
> >From: Ky Srinivasan [ksrinivasan@novell.com]  -  Friday, May 07, 2010 4:52 PM
> >
> > I am attaching a patch to auto-load hv_netvsc.
> 
> I am not sure if this is the right approach. hv_netvsc takes a dependency on hv_vmbus.
> hv_vmbus does have the same DMI detection logic in it. But unless hv_vmbus has loaded
> up competely, hv_netvsc will fail on loadup. And I do not think we can guarantee that
> hv_vmbus has loaded yet.

Yes you can, the dependancies in the module will take care of it.  Try
it, if you try to load the hv_netvsc module before hv_vmbus, modprobe
will load hv_vmbus first.

> It would be better to have netvsc check to make sure hv_vmbus is loaded.

How would you do that?  The symbol resolution will not allow hv_netvsc
to be loaded without hv_vmbus being around.

Now I do think that just adding the same pci/dmi ids to all of the
modules is a bit odd, and that something else needs to be done here, but
at the moment, I can't think of anything better.

thanks,

greg k-h
