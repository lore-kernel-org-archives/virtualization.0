From: Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Wed, 19 Nov 2008 08:09:22 +0100
Message-ID: <4923BBA2.1070609__12694.2096896984$1227111789$gmane$org@unimore.it>
References: <20081113.180558.519459540419535699.ryov@valinux.co.jp>	
	<af41c7c40811131041t1b8491b6la5574ebe75f89000@mail.gmail.com>	
	<20081113214642.GG7542@redhat.com>	
	<af41c7c40811131457w472e4a86tb5344cc1d3d366fb@mail.gmail.com>	
	<20081114160525.GE24624@redhat.com>	
	<e98e18940811141444u5947b806v27fac453ed1e8a5@mail.gmail.com>	
	<20081117142309.GA15564@redhat.com>
	<4922224A.5030502@cn.fujitsu.com>	
	<e98e18940811172101na345b6bh5c73f9e657aac5a7@mail.gmail.com>	
	<20081118120508.GD15268@gandalf.sssup.it>
	<e98e18940811181433o4bb5a147i1e0b9c1baf495ae2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <e98e18940811181433o4bb5a147i1e0b9c1baf495ae2@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nauman Rafique <nauman@google.com>
Cc: menage@google.com, riel@redhat.com, akpm@linux-foundation.org, jmoyer@redhat.com, containers@lists.linux-foundation.org, Li Zefan <lizf@cn.fujitsu.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, taka@valinux.co.jp, peterz@infradead.org, Fabio Checconi <fchecconi@gmail.com>, Divyesh Shah <dpshah@google.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, Vivek Goyal <vgoyal@redhat.com>, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Nauman Rafique ha scritto:
>
>
> I think "time only budget" vs "sector budget" is dependent on the
> definition of fairness: do you want to be fair in the time that is
> given to each cgroup or fair in total number of sectors transferred.
> And the appropriate definition of fairness depends on how/where the IO
> scheduler is used. ...
>
>   
Just a general note: as Fabio already said, switching back to time 
budgets in BFQ would be (conceptually) straightforward.
However, we will never get fairness in bandwidth distribution if we work 
(only) in the time domain.



-- 
-----------------------------------------------------------
| Paolo Valente              |                            |
| Algogroup                  |                            |
| Dip. Ing. Informazione     | tel:   +39 059 2056318     |
| Via Vignolese 905/b	     | fax:   +39 059 2056199     |
| 41100 Modena               | 				  |
|     home:  http://algo.ing.unimo.it/people/paolo/       |
-----------------------------------------------------------
