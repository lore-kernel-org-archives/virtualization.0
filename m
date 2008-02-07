From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Xen paravirt frontend block hang
Date: Thu, 07 Feb 2008 15:09:02 +1100
Message-ID: <47AA845E.8020708@goop.org>
References: <4772AC8E.7010007@theshore.net> <47758352.5040504@goop.org>	
	<479E71B7.7060207@theshore.net> <479E75E3.6030601@goop.org>	
	<479E7BA4.5050306@theshore.net>
	<519a8b110802060437k70c099b7y7faefe63dd82039@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <519a8b110802060437k70c099b7y7faefe63dd82039@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xming <xmingske@gmail.com>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

xming wrote:
> But I do have one problem after I upgraded to xen 3.2, the 2.6.23.x domU do
> not boot any more and 2.6.24 does boot but will hang after cpufreq changes
> the frequency.
>   

Interesting.  Do you mean dom0 cpufreq frequency changes will cause the 
domU to hang?

    J
