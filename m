From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/6] vhost_vdpa: support doorbell mapping via mmap
Date: Tue, 2 Jun 2020 00:56:54 -0400
Message-ID: <20200602005007-mutt-send-email-mst@kernel.org>
References: <20200529080303.15449-5-jasowang@redhat.com>
 <202006020308.kLXTHt4n%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <202006020308.kLXTHt4n%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, kbuild-all@lists.01.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 02, 2020 at 03:22:49AM +0800, kbuild test robot wrote:
> Hi Jason,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on vhost/linux-next]
> [also build test ERROR on linus/master v5.7 next-20200529]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Jason-Wang/vDPA-doorbell-mapping/20200531-070834
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> config: m68k-randconfig-r011-20200601 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> drivers/vhost/vdpa.c: In function 'vhost_vdpa_fault':
> >> drivers/vhost/vdpa.c:754:22: error: implicit declaration of function 'pgprot_noncached' [-Werror=implicit-function-declaration]
> 754 |  vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> |                      ^~~~~~~~~~~~~~~~
> >> drivers/vhost/vdpa.c:754:22: error: incompatible types when assigning to type 'pgprot_t' {aka 'struct <anonymous>'} from type 'int'
> cc1: some warnings being treated as errors
> 
> vim +/pgprot_noncached +754 drivers/vhost/vdpa.c
> 
>    742	
>    743	static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
>    744	{
>    745		struct vhost_vdpa *v = vmf->vma->vm_file->private_data;
>    746		struct vdpa_device *vdpa = v->vdpa;
>    747		const struct vdpa_config_ops *ops = vdpa->config;
>    748		struct vdpa_notification_area notify;
>    749		struct vm_area_struct *vma = vmf->vma;
>    750		u16 index = vma->vm_pgoff;
>    751	
>    752		notify = ops->get_vq_notification(vdpa, index);
>    753	
>  > 754		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>    755		if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
>    756				    notify.addr >> PAGE_SHIFT, PAGE_SIZE,
>    757				    vma->vm_page_prot))
>    758			return VM_FAULT_SIGBUS;
>    759	
>    760		return VM_FAULT_NOPAGE;
>    761	}
>    762	

Yes well, all this remapping clearly has no chance to work
on systems without CONFIG_MMU.



> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
