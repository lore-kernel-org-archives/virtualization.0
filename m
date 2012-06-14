From: Jens Axboe <axboe@kernel.dk>
Subject: =?windows-1252?Q?Re=3A_drivers/block/cpqarray=2Ec=3A938=3A2=3A?=
	=?windows-1252?Q?_error=3A_too_many_arguments_to_function_?=
	=?windows-1252?Q?=91blk=5Frq=5Fmap=5Fsg=92?=
Date: Thu, 14 Jun 2012 08:30:11 +0200
Message-ID: <4FD984F3.3070502__46234.0261474766$1339682749$gmane$org@kernel.dk>
References: <4fd91c3f.KAwMcygw9fFGn9Cx%wfg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4fd91c3f.KAwMcygw9fFGn9Cx%wfg@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: wfg@linux.intel.com
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 06/14/2012 01:03 AM, wfg@linux.intel.com wrote:
> FYI, kernel build failed on
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git multiqueue
> head:   e9a6aa8a0b7b93195774a9fcf551632bf3abcd97
> commit: 67db7275fa4325d46853a4bfcb79acf32e48eca8 [1/3] multiqueue: a hodge podge of things

The multiqueue branch is a private branch, it's known broken on many
configs at the moment.

-- 
Jens Axboe
