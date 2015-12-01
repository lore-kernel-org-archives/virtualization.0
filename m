From: "Sinclair Yeh" <syeh@vmware.com>
Subject: Re: [PATCH 6/6] VMware balloon: Update vmw_balloon.c to use the
	VMW_PORT macro
Date: Tue, 1 Dec 2015 15:17:54 -0800
Message-ID: <20151201231754.GB11239__35116.0659025938$1449011808$gmane$org@syeh-linux>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-6-git-send-email-syeh@vmware.com>
	<20151201223801.GN24642@xdeguillard-ws.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151201223801.GN24642@xdeguillard-ws.eng.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Xavier Deguillard <xdeguillard@vmware.com>
Cc: pv-drivers@vmware.com, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Thanks!  Done.

On Tue, Dec 01, 2015 at 02:38:01PM -0800, Xavier Deguillard wrote:
> Hey Sinclair,
> 
> On Tue, Dec 01, 2015 at 02:18:52PM -0800, Sinclair Yeh wrote:
> > +#define VMWARE_BALLOON_CMD(cmd, data, result)			   \
> > +({								   \
> > +	unsigned long __status, __dummy1, __dummy2;		   \
> > +	unsigned long __si = 0, __di = 0;			   \
> > +	VMW_PORT(data, VMW_BALLOON_CMD_##cmd, VMW_BALLOON_HV_PORT, \
> > +		 VMW_BALLOON_HV_MAGIC,				   \
> > +		 __status, result, __dummy1, __dummy2, __si, __di);\
> > +	if (VMW_BALLOON_CMD_##cmd == VMW_BALLOON_CMD_START)	   \
> > +		result = __dummy1;				   \
> > +	result &= -1UL;						   \
> > +	__status & -1UL;					   \
> >  })
> 
> You need to indent the '\' with tabs only, and it looks like spaces are
> present here (which is also why they don't look aligned).
> 
> Other than that I'm good with this:
> 
> Acked-by: Xavier Deguillard <xdeguillard@vmware.com>
> 
> Xavier
