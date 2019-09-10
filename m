From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] x86/paravirt: Use a single ops structure
Date: Tue, 10 Sep 2019 17:53:20 +0300
Message-ID: <20190910145320.GA1479@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jgross@suse.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello Juergen Gross,

The patch 5c83511bdb98: "x86/paravirt: Use a single ops structure"
from Aug 28, 2018, leads to the following static checker warning:

	arch/x86/kernel/paravirt.c:123 paravirt_patch_default()
	warn: uncapped user index '*(&pv_ops + type)'

	arch/x86/kernel/paravirt.c:124 paravirt_patch_default()
	error: buffer overflow '&pv_ops' 90 <= 255 user_rl='0-255'

arch/x86/kernel/paravirt.c
   116  unsigned paravirt_patch_default(u8 type, void *insn_buff,
   117                                  unsigned long addr, unsigned len)
   118  {
   119          /*
   120           * Neat trick to map patch type back to the call within the
   121           * corresponding structure.
   122           */
   123          void *opfunc = *((void **)&pv_ops + type);
                                          ^^^^^^^^^^^^^^
This code is actually pretty old...

This isn't a security issue, but the size of &pv_ops is variable but
type isn't checked so we could be reading beyond the end.  We could do
something like:

        if (type >= sizeof(pv_ops) / sizeof(void *))
                return -EINVAL;
	opfunc = *((void **)&pv_ops + type);

   124          unsigned ret;
   125  
   126          if (opfunc == NULL)
   127                  /* If there's no function, patch it with a ud2a (BUG) */
   128                  ret = paravirt_patch_insns(insn_buff, len, ud2a, ud2a+sizeof(ud2a));
   129          else if (opfunc == _paravirt_nop)
   130                  ret = 0;
   131  

regards,
dan carpenter
