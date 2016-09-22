From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v7 6/6] powerpc: pSeries: Add pv-qspinlock build
	config/make
Date: Thu, 22 Sep 2016 20:31:59 +1000
Message-ID: <87a8f08bts.fsf__2467.3985819847$1474829895$gmane$org@concordia.ellerman.id.au>
References: <201609191651.3BF51xRa%fengguang.wu@intel.com>
	<57E37216.1030505@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <57E37216.1030505@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xinhui <xinhui.pan@linux.vnet.ibm.com>, kbuild test robot <lkp@intel.com>
Cc: peterz@infradead.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, waiman.long@hpe.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, kbuild-all@01.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

xinhui <xinhui.pan@linux.vnet.ibm.com> writes:

> hi, all
> 	ok, this patch set depends on
> https://patchwork.kernel.org/patch/8953981/ [V4] powerpc: Implement {cmp}xchg for u8 and u16

AKA: https://patchwork.ozlabs.org/patch/615480/

Sorry I saw the discussion on that and thought there'd be a new version.
But now I read the whole thread it looks like it was OK in the end.

I'll try and get it merged.

cheers
