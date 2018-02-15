From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [vhost:vhost 24/24] drivers/firmware/qemu_fw_cfg.c:499:22:
	error: storage size of 'files' isn't known
Date: Thu, 15 Feb 2018 20:26:26 +0200
Message-ID: <20180215202603-mutt-send-email-mst__7221.20312643728$1518719109$gmane$org@kernel.org>
References: <201802150430.8hqex8Tw%fengguang.wu@intel.com>
	<CAMxuvawhzjNA8gQSCpVtff-A6-Umg6fPz37nPhqRrDiRwKqUCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAMxuvawhzjNA8gQSCpVtff-A6-Umg6fPz37nPhqRrDiRwKqUCQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kbuild-all@01.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, kbuild test robot <fengguang.wu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 15, 2018 at 10:46:50AM +0100, Marc-Andre Lureau wrote:
> Hi
> 
> On Wed, Feb 14, 2018 at 9:27 PM, kbuild test robot
> <fengguang.wu@intel.com> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
> > head:   5d457fe6aeaab9d0a1665eafc8af7139bc6b6f2e
> > commit: 5d457fe6aeaab9d0a1665eafc8af7139bc6b6f2e [24/24] fw_cfg: fix sparse warnings around FW_CFG_FILE_DIR read
> > config: i386-randconfig-x015-201806 (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> > reproduce:
> >         git checkout 5d457fe6aeaab9d0a1665eafc8af7139bc6b6f2e
> >         # save the attached .config to linux build tree
> >         make ARCH=i386
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/firmware/qemu_fw_cfg.c: In function 'fw_cfg_register_dir_entries':
> >>> drivers/firmware/qemu_fw_cfg.c:499:22: error: storage size of 'files' isn't known
> >      struct fw_cfg_files files;
> >                          ^~~~~
> 
> struct fw_cfg_files {
>         __be32 count; /* number of entries */
>         struct fw_cfg_file f[];
> };
> 
> Interesting, I don't have that warning with 7.3.1.
> 
> I thought the size would be sizeof(count) by standard.
> 
> I replaced it with a __be32 files_count variable instead.
> 
> >    drivers/firmware/qemu_fw_cfg.c:499:22: warning: unused variable 'files' [-Wunused-variable]
> >
> 
> files.count is used 3 lines below, that looks like a compiler bug to me.


No - i tried dropping one patch out of series, this did not work out.
So whole series is out for now.

> > vim +499 drivers/firmware/qemu_fw_cfg.c
> >
> >    493
> >    494  /* iterate over all fw_cfg directory entries, registering each one */
> >    495  static int fw_cfg_register_dir_entries(void)
> >    496  {
> >    497          int ret = 0;
> >    498          u32 count, i;
> >  > 499          struct fw_cfg_files files;
> >    500          struct fw_cfg_file *dir;
> >    501          size_t dir_size;
> >    502
> >    503          fw_cfg_read_blob(FW_CFG_FILE_DIR, &files.count, 0, sizeof(files.count));
> >    504          count = be32_to_cpu(files.count);
> >    505          dir_size = count * sizeof(struct fw_cfg_file);
> >    506
> >    507          dir = kmalloc(dir_size, GFP_KERNEL);
> >    508          if (!dir)
> >    509                  return -ENOMEM;
> >    510
> >    511          fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(files.count), dir_size);
> >    512
> >    513          for (i = 0; i < count; i++) {
> >    514                  ret = fw_cfg_register_file(&dir[i]);
> >    515                  if (ret)
> >    516                          break;
> >    517          }
> >    518
> >    519          kfree(dir);
> >    520          return ret;
> >    521  }
> >    522
> >
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
