From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 6/6] Guest page hinting: s390 support.
Date: Thu, 13 Mar 2008 09:07:16 -0700
Message-ID: <47D95134.6030503@goop.org>
References: <20080312132132.520833247@de.ibm.com>	<20080312132704.474209626@de.ibm.com>	<47D802A2.1030406@goop.org>	<1205339285.8851.13.camel@localhost>	<47D8085E.9030701@goop.org>	<1205341164.8851.44.camel@localhost>	<47D81771.5070400@goop.org>	<47D8373C.40105@codemonkey.ws>	<47D840E3.5090902@goop.org>	<47D8436F.9080901@codemonkey.ws>  <47D84CEB.6050300@goop.org> <1205401508.26537.37.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755504AbYCMQJU@vger.kernel.org>
In-Reply-To: <1205401508.26537.37.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, akpm@osdl.org, linux-s390@vger.kernel.org, frankeh@watson.ibm.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Anthony Liguori <anthony@codemonkey.ws>, hugh@veritas.com
List-Id: virtualization@lists.linuxfoundation.org

Martin Schwidefsky wrote:
> Vz->Vr cannot happen. This would be a bug in the host.
>   

Does that mean that Vz is effectively identical to Uz?

    J
