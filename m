From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [vmw_vmci 11/11] Apply the header code to make VMCI build
Date: Fri, 27 Jul 2012 11:16:39 -0700
Message-ID: <20120727181639.GA23564@kroah.com>
References: <20120727103455.GA4639@merkur.ravnborg.org>
	<1693394101.5749000.1343409643934.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1693394101.5749000.1343409643934.JavaMail.root@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Stiegmann <astiegmann@vmware.com>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, vm-crosstalk@vmware.com, Sam Ravnborg <sam@ravnborg.org>, cschamp@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 27, 2012 at 10:20:43AM -0700, Andrew Stiegmann wrote:
> > The kernel style is to use lower_case for everything.
> > So this would become:
> > 
> >     vmci_device_get()
> > 
> > This is obviously a very general comment and applies everywhere.
> 
> I wish I could lower case these symbols but VMCI has already existed
> outside the mainline Linux tree for some time now and changing these
> exported symbols would mean that other drivers that depend on VMCI
> (vSock, vmhgfs) would need to change as well.   One thought that did
> come to mind was exporting both VMCI_Device_Get and vmci_device_get
> but that would likely just confuse people.  So in short I have made
> function names lower case where possible, but exported symbols could
> not be changed.

Not true at all.  You want those drivers to be merged as well, right?
So they will need to have their functions changed, and their code as
well.

Just wait until we get to the "change your functionality around"
requests, those will require those drivers to change.  Right now we are
at the "silly and obvious things you did wrong" stage of the review
process :)

So please fix these, and also, post these drivers as well, so we can see
how they interact with the core code.

Actually, if you are going to need lots of refactoring for these
drivers, and the core, I would recommend putting this all in the staging
tree, to allow that to happen over time.  That would ensure that your
users keep having working systems, and let you modify the interfaces
better and easier, than having to keep it all out-of-tree.

What do you think?

greg k-h
